package routes

import (
	"entry/config"
	"entry/functions"

	"github.com/gin-gonic/gin"
)

type Dataa struct {
	Level string `json:"level"`
	Mark  string `json:"marks"`
}
type Inputt struct {
	Roll string `json:"roll_no"`
}

func GetPSMark(c *gin.Context) {
	var Id Inputt
	data := []Dataa{}
	if err := c.ShouldBindJSON(&Id); err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}
	row, err := config.Database.Query("SELECT ps.level,psm.marks FROM ps_level_marks psm INNER JOIN ps_levels ps ON ps.id = psm.level INNER JOIN user_table us ON us.roll_no = psm.student WHERE NOT psm.level ='10' AND NOT psm.level ='11' AND NOT psm.level ='12' AND us.roll_no =? GROUP BY ps.level,psm.marks", Id.Roll)
	if err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}
	for row.Next() {
		var temp Dataa
		row.Scan(&temp.Level, &temp.Mark)
		data = append(data, temp)
	}

	functions.Response(c, 200, "", map[string]interface{}{
		"success": true,
		"data":    data,
	})
}
