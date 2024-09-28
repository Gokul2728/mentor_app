package main

import (
	"entry/config"
	"entry/functions"
	api "entry/routes"
	auth "entry/routes/auth"
	home "entry/routes/dashboard"
	"os"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	config.ConnectDB()
	defer config.Database.Close()
	appPort := os.Getenv("APP_PORT")
	//
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()
	//
	r.Use(cors.New(cors.Config{
		AllowOrigins: []string{"https://learnathon.bitsathy.ac.in", "http://10.150.252.165:8010"},
		AllowMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders: []string{"Origin", "Content-Type", "Authorization"},
	}))
	//Login --
	r.POST("/mentor/login", auth.AuthGLogin)
	//Home ----
	r.POST("/mentor/list", home.GetStudentList)
	r.POST("/mentor/break_points", home.GetBreakPoints)
	//Profile ---
	r.POST("/mentor/profile", api.GetStudentProfile)
	r.POST("/mentor/placement", api.GetPlacementMark)
	r.POST("/mentor/ps", api.GetPSMark)

	//
	r.NoRoute(func(c *gin.Context) {
		functions.Response(c, 404, "API Not Found", nil)
	})
	r.Run(":" + appPort)
}
