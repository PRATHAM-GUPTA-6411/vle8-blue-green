# VLE-8 Blue-Green Deployment — Progress Checkpoint

## Completed
- [x] Created Blue and Green HTML pages
- [x] Created Dockerfiles for both environments
- [x] Built Docker images: vle8-blue:v1 and vle8-green:v1
- [x] Loaded both images into Minikube
- [x] Created Blue and Green Kubernetes deployments (2 replicas each)
- [x] Created Kubernetes Service
- [x] Verified Service traffic to Blue
- [x] Switched Service traffic to Green and verified response
- [x] Rolled back Service traffic to Blue and verified response
- [x] Installed and verified Terraform and Ansible
- [x] Ran Ansible environment verification playbook

## Current deployment
- Blue deployment: 2 replicas
- Green deployment: 2 replicas
- Service: vle8-blue-green-service
- Current Service selector: color=blue

## Remaining
- [ ] Configure and run Jenkins Blue-Green pipeline
- [ ] Demonstrate deployment approval and traffic switching through Jenkins
- [ ] Complete meaningful Terraform infrastructure-as-code work
- [ ] Complete Ansible configuration/automation evidence
- [ ] Collect and organize screenshots
- [ ] Prepare final report

## Screenshot evidence
- SS01: Environment setup — pending
- SS02: Docker images built — pending
- SS03: Kubernetes deployments — pending
- SS04: Blue traffic verified — pending
- SS05: Green traffic switched — pending
- SS06: Rollback to Blue — captured by user
