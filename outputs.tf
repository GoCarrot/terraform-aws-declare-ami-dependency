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

output "circleci_project_slug" {
  description = <<-EOT
  The CircleCI project slug, e.g. gh/ExampleOrg/ExampleRepo, for the _current_ project. This is the
  CircleCI project that will be triggered when an AMI update is required for the _current_ project.
EOT
  value       = var.circleci_project_slug
}

output "source_ami_name_prefix" {
  description = <<-EOT
  The AMI name prefix of the AMI that the _current_ project's AMI is built from.
EOT
  value       = var.source_ami_name_prefix
}

output "branch" {
  description = <<-EOT
  The name of the branch in the _current_ repo to build on a change.
EOT
  value       = var.branch
}

output "build_from_account" {
  description = <<-EOT
  The accountomat canonical slug of the account to build the new AMI in.
EOT
  value       = var.build_from_account
}

output "deploy_to_account" {
  description = <<-EOT
  The accountomat canonical slug of the account to deploy the freshly built AMI to. This may be blank or null in which case
  the AMI will be updated but no deploys will be attempted.
EOT
  value       = var.deploy_to_account
}
