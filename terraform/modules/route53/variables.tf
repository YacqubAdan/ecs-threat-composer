variable "root_domain" {
    type        = string
    description = "The root domain"
}

variable "dns_record_ttl" {
    type        = number
    description = "The TTL for the DNS record"
}


variable "alb_dns" {
    type        = string
    description = "The dns of the alb"
}

variable "alb_zone_id" {
    type        = string
    description = "The zone id of alb"
}