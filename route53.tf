resource "aws_route53_zone" "bunjow" {
  name              = "bunjow.com"
  delegation_set_id = "N09809842QB0DD1BVGDXR"
  force_destroy     = true
}

resource "aws_route53_record" "mail1-record" {
  zone_id         = aws_route53_zone.bunjow.zone_id
  name            = "bunjow.com"
  type            = "MX"
  ttl             = "300"
  allow_overwrite = true
  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com.",
  ]
}

resource "aws_route53_record" "bunjow-record" {
  zone_id         = aws_route53_zone.bunjow.zone_id
  name            = "bunjow.com"
  type            = "A"
  ttl             = "300"
  allow_overwrite = true
  records         = [aws_instance.MattApache.public_ip]
}

resource "aws_route53_record" "www-record" {
  zone_id         = aws_route53_zone.bunjow.zone_id
  name            = "www.bunjow.com"
  type            = "CNAME"
  ttl             = "300"
  allow_overwrite = true
  records         = ["bunjow.com"]
}

resource "aws_route53_record" "MattApache-record" {
  zone_id         = aws_route53_zone.bunjow.zone_id
  name            = "MattApache.bunjow.com"
  type            = "CNAME"
  ttl             = "300"
  allow_overwrite = true
  records         = ["bunjow.com"]
}

##resource "aws_route53_record" "defaultNginx-record" {
##  zone_id         = aws_route53_zone.bunjow.zone_id
##  name            = "defaultNginx.bunjow.com"
##  type            = "A"
##  ttl             = "300"
##  allow_overwrite = true
##  records         = [aws_instance.defaultNginx.public_ip]
##}

##resource "aws_route53_record" "MattNginx-record" {
##  zone_id         = aws_route53_zone.bunjow.zone_id
##  name            = "MattNginx.bunjow.com"
##  type            = "A"
##  ttl             = "300"
##  allow_overwrite = true
##  records         = [aws_instance.MattNginx.public_ip]
##}

resource "aws_route53_record" "MariadbConsole-record" {
  zone_id         = aws_route53_zone.bunjow.zone_id
  name            = "MariadbConsole.bunjow.com"
  type            = "A"
  ttl             = "300"
  allow_overwrite = true
  records         = [aws_instance.mariadb-console.public_ip]
}

output "ns-servers" {
  value = aws_route53_zone.bunjow.name_servers
}

