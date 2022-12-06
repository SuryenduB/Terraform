terraform {
  cloud {
    organization = "suryendubbhattacharyya"

    workspaces {
      name = "prod"
    }
  }
}