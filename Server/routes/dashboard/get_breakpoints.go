package routes

import (
	"entry/config"
	"entry/functions"

	"github.com/gin-gonic/gin"
)

type BreakPoints struct {
	Tittle string `json:"bp_title"`
	Points string `json:"points"`
	Date   string `json:"date"`
}
type RollNo struct {
	Roll string `json:"roll_no"`
}

func GetBreakPoints(c *gin.Context) {
	var id RollNo
	data := []BreakPoints{}
	if err := c.ShouldBindJSON(&id); err != nil {
		functions.Response(c, 500, "Invalid input", nil)
		return
	}
	row, err := config.Database.Query("SELECT bp_title, points,date FROM break_points_log WHERE STATUS = 1 AND roll_no = ? ORDER BY DATE", id.Roll)
	if err != nil {
		functions.Response(c, 500, err.Error(), nil)
		return
	}
	for row.Next() {
		var temp BreakPoints
		row.Scan(&temp.Tittle, &temp.Points, &temp.Date)
		data = append(data, temp)
	}

	functions.Response(c, 200, "", map[string]interface{}{
		"success": true,
		"data":    data,
	})
}
