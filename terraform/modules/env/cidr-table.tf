variable "cidrblocktable" {
    type = "map"

    default = {
        chaordic-lab                = "10.10.0.0/20"
    }
}

output "cidrblockip" {
    value = "${lookup(var.cidrblocktable, var.project)}"
}
