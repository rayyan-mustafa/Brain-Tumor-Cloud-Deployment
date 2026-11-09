# Brain Tumor Classification: EfficientNet-B4 on Docker + AWS EC2 (Terraform)

A PyTorch image classifier for brain MRI scans, packaged in Docker and deployed to AWS EC2 with Terraform (infrastructure as code).

## Overview
- **Task:** 4-class classification: Glioma, Meningioma, No Tumor, Pituitary
- **Data:** 1,311 labelled MRI images
- **Model:** EfficientNet-B4 (ImageNet-pretrained weights, transfer learning), PyTorch
- **Training:** 25 epochs (see `Code.ipynb`)
- **Deployment:** Docker container on an AWS EC2 instance provisioned with Terraform (VPC security group, key pair, instance); EC2 user-data script installs Docker and starts the container on boot, serving on port 8000

## Results
All numbers below are the real values logged in `Code.ipynb` (validation set).

| Metric | Value |
|---|---|
| Final validation accuracy (epoch 25) | **95.12%** |
| Best validation accuracy (epoch 18) | 95.42% |
| Final training loss / validation loss | 0.1306 / 0.1153 |
| Lowest validation loss (epoch 24) | 0.1028 |

Validation accuracy rose from 82.76% (epoch 1) to above 94% by epoch 16 and then plateaued around 94-95%.

## Limitations
- Metrics are on a validation split; no separate held-out test set or per-class report (confusion matrix, precision/recall) has been recorded yet.
- This is a learning/portfolio project, not a medical device, and must not be used for diagnosis.

## Infrastructure
- `Dockerfile`: container image for the inference app
- Terraform files (`main.tf`): EC2 instance, security group and key pair
- EC2 user-data (Bash): system updates, Docker install, container launch

## Next steps
- Evaluate on a held-out test set and add a per-class confusion matrix and precision/recall
- Add dropout/regularization and compare
