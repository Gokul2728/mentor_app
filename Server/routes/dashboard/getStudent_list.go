package routes

import (
	"entry/config"
	"entry/functions"

	"github.com/gin-gonic/gin"
)

type StudentLsit struct {
	Roll string `json:"roll_no"`
	Name string `json:"name"`
}
type Input struct {
	Email string `json:"email"`
}

func GetStudentList(c *gin.Context) {
	var id Input
	data := []StudentLsit{}
	if err := c.ShouldBindJSON(&id); err != nil {
		functions.Response(c, 500, "Invalid input", nil)
		return
	}
	row, err := config.Database.Query("SELECT us.roll_no,us.name FROM user_table us INNER JOIN mentor m ON m.id = us.mentor WHERE m.email = ?", id.Email)
	if err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}
	for row.Next() {
		var temp StudentLsit
		row.Scan(&temp.Roll, &temp.Name)
		data = append(data, temp)
	}

	functions.Response(c, 200, "", map[string]interface{}{
		"success": true,
		"data":    data,
	})
}
