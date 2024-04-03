resource "aws_ecr_repository" "foo" {
  count                = length(var.container_name)
  name                 = var.container_name[count.index]
  image_tag_mutability = var.mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}
