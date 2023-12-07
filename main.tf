# Copyright 2022 Teak.io, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3, < 6"
    }
  }
}

module "ci_cd_account" {
  source  = "GoCarrot/accountomat_read/aws"
  version = "0.0.4"

  canonical_slug = var.build_from_account
}

locals {
  parameter_prefix = "${module.ci_cd_account.param_prefix}/config/image_factories/${var.source_ami_name_prefix}"

  slugified_project_slug = trim(replace(lower(var.circleci_project_slug), "/[^a-z0-9-_.]/", "-"), "-")

  update_config = {
    project_slug   = var.circleci_project_slug,
    branch         = var.branch,
    build_account  = var.build_from_account,
    deploy_account = var.deploy_to_account
  }
}

resource "aws_ssm_parameter" "build-trigger" {
  name  = "${local.parameter_prefix}/dependents/${local.slugified_project_slug}-${var.branch}"
  type  = "String"
  value = jsonencode(local.update_config)
}
