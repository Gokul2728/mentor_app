package routes

// import (
// 	"entry/config"
// 	"entry/functions"

// 	"github.com/gin-gonic/gin"
// )

// type Home struct {
// 	Id    string `json:"id"`
// 	Name  string `json:"name"`
// 	Email string `json:"email"`
// 	Role  string `json:"role"`
// }

// func GetHome(c *gin.Context) {

// 	data := []Home{}
// 	row, err := config.Database.Query("SELECT m.id,m.name,m.email,rm.role,m.profile_img FROM mentor m INNER JOIN role_master rm ON rm.id = m.role_id WHERE rm.id ='1' AND m.email = ? LIMIT 1", c.MustGet("userId"))
// 	if err != nil {
// 		functions.Response(c, 500, err.Error(), nil)
// 		return
// 	}
// 	for row.Next() {
// 		var temp Home
// 		row.Scan(&temp.Roll, &temp.Name)
// 		data = append(data, temp)
// 	}

// 	functions.Response(c, 200, "", map[string]interface{}{
// 		"success": true,
// 		"data":    data,
// 	})
// }
