package routes

import (
	"entry/config"
	"entry/functions"

	"github.com/gin-gonic/gin"
)

type Total struct {
	Entry   int `json:"total_entry"`
	Exit    int `json:"total_exit"`
	Student int `json:"total_students"`
	Parents int `json:"parents_count"`
}

func GetTotal(c *gin.Context) {
	var total Total

	err := config.Database.QueryRow("SELECT COUNT(*)AS total_entry FROM graduate_entries WHERE TYPE ='Entry'").Scan(&total.Entry)
	if err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}

	err = config.Database.QueryRow("select COUNT(*)AS total_exit FROM graduate_entries where type ='Exit'").Scan(&total.Exit)
	if err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}

	err = config.Database.QueryRow("select sum(student_count)AS total_students FROM graduate_entries").Scan(&total.Student)
	if err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}
	err = config.Database.QueryRow("select sum(parents_count)AS total_parents FROM graduate_entries").Scan(&total.Parents)
	if err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}

	functions.Response(c, 200, "", map[string]interface{}{"data": total})
}
