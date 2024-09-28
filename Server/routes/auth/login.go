package auth

import (
	"database/sql"
	"encoding/json"
	"entry/config"
	"entry/functions"
	"entry/models"
	"fmt"
	"io/ioutil"
	"net/http"

	"github.com/gin-gonic/gin"
)

func AuthGLogin(c *gin.Context) {
	var input models.AuthGLoginResquest
	var response map[string]interface{}
	var data models.AuthLoginResponse

	if err := c.ShouldBindJSON(&input); err != nil {
		functions.Response(c, http.StatusBadRequest, "Invalid input", nil)
		return
	}

	email, profile, err := GetEmailId(input.Token)
	if err != nil {
		functions.Response(c, http.StatusInternalServerError, "Failed to get email from token", nil)
		return
	}

	data.ProfileImg = profile

	err = config.Database.QueryRow(`
        SELECT us.roll_no AS id, us.name,us.email, rm.role
        FROM user_table us 
        INNER JOIN role_master rm ON rm.id = us.role_id 
        WHERE rm.id = '2' AND us.email = ?`, email).Scan(&data.Id, &data.Name, &data.Email, &data.Role)

	if err != nil {
		if err == sql.ErrNoRows {

			err = config.Database.QueryRow(`
                SELECT m.id, m.name,m.email,rm.role
                FROM mentor m 
                INNER JOIN role_master rm ON rm.id = m.role_id 
                WHERE rm.id = '1' AND m.email = ?`, email).Scan(&data.Id, &data.Name, &data.Email, &data.Role)

			if err != nil {
				if err == sql.ErrNoRows {

					functions.Response(c, http.StatusUnauthorized, "Invalid Username", nil)
					return
				}

				functions.Response(c, http.StatusInternalServerError, "Failed to retrieve mentor data", nil)
				return
			}

			_, err = config.Database.Exec("UPDATE mentor SET profile_img = ? WHERE id = ?", profile, data.Id)
			if err != nil {
				functions.Response(c, http.StatusInternalServerError, "Failed to update mentor profile image", nil)
				return
			}

		} else {

			functions.Response(c, http.StatusInternalServerError, "Failed to retrieve student data", nil)
			return
		}
	} else {

		_, err = config.Database.Exec("UPDATE user_table SET profile_img = ? WHERE roll_no = ?", profile, data.Id)
		if err != nil {
			functions.Response(c, http.StatusInternalServerError, "Failed to update student profile image", nil)
			return
		}
	}

	response = map[string]interface{}{
		"success": true,
		"data":    data,
	}
	c.JSON(http.StatusOK, response)
}

func GetEmailId(accessToken string) (string, string, error) {
	type UserInfo struct {
		Email   string `json:"email"`
		Picture string `json:"picture"`
	}

	url := fmt.Sprintf("https://www.googleapis.com/oauth2/v1/userinfo?access_token=%s", accessToken)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		fmt.Println("Error creating request:", err)
		return "", "", err
	}

	req.Header.Add("Authorization", "Bearer "+accessToken)
	req.Header.Add("Accept", "application/json")

	resp, err := client.Do(req)
	if err != nil {
		fmt.Println("Error making request:", err)
		return "", "", err
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("Error reading response body:", err)
		return "", "", err
	}

	var userInfo UserInfo
	if err := json.Unmarshal(body, &userInfo); err != nil {
		fmt.Println("Error unmarshalling JSON:", err)
		return "", "", err
	}

	return userInfo.Email, userInfo.Picture, nil
}
