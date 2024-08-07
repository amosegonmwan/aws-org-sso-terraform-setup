# AWS Organization and SSO Setup with Terraform

This repository contains Terraform configurations to set up an AWS Organization, organizational units (OUs), accounts, and SSO permission sets.

## File Structure

### `data.tf`

Defines the data sources for AWS Organizations and SSO instances.

### `locals.tf`

Defines local values used in the configuration, such as SSO instance ID, AWS Organization ID, and EKS permission policy statement.

### * `main.tf`

Defines the resources for creating organizational units and accounts in AWS Organizations.

###  `output.tf`

Outputs the root organizational unit ID and account IDs.

### `permission_sets.tf`

Defines the SSO permission sets and account assignments.

### `provider.tf`

Defines the AWS provider configuration and backend settings.

### `variables.tf`

Defines the input variables for the configuration.

## Setup

1. **Install Terraform**: Ensure Terraform is installed on your machine. Refer to the [Terraform installation guide](https://www.terraform.io/downloads.html) for instructions.

2. **Clone the Repository**:
   ```sh
   git clone https://github.com/yourusername/aws-org-sso-terraform.git
   cd aws-org-sso-terraform

### License
This project is licensed under the MIT License - see the LICENSE file for details.

### Contact
For any questions or support, please contact amos.egonmwan@gmail.com.
