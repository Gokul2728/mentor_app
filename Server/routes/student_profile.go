package routes

import (
	"entry/config"
	"entry/functions"

	"github.com/gin-gonic/gin"
)

type Student struct {
	Roll string `json:"roll_no"`
	Name string `json:"name"`
	Year string `json:"year"`
	Sem  string `json:"sem"`
	Dept string `json:"dept"`
	Role string `json:"role"`
	IMg  string `json:"profile_img"`
}
type Inputdata struct {
	Roll string `json:"roll_no"`
}

func GetStudentProfile(c *gin.Context) {
	var data Student
	var Id Inputdata
	if err := c.ShouldBindJSON(&Id); err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}
	err := config.Database.QueryRow(`SELECT us.roll_no,us.name,ay.year,ay.sem,dt.short_name AS dept,rm.role,us.profile_img FROM user_table us 
									 INNER JOIN academic_year ay ON us.ac_year = ay.id
									 INNER JOIN departments dt ON dt.id = us.dept
									 INNER JOIN role_master rm ON rm.id = us.role_id
									 WHERE rm.id ='2' AND us.roll_no = ?`, Id.Roll).Scan(&data.Role, &data.Name, &data.Year, &data.Sem, &data.Dept, &data.Role, &data.IMg)
	if err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}

	functions.Response(c, 200, "", map[string]interface{}{"data": data})
}
