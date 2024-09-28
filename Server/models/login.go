package models

type AuthGLoginResquest struct {
	Token string `json:"token" binding:"required"`
}

type AuthLoginResponse struct {
	Id         string `json:"id"`
	Name       string `json:"name"`
	ProfileImg string `json:"profile_img"`
	Email      string `json:"email"`
	Role       string `json:"role"`
}
