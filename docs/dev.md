# 🟢 Dev Environment

এই পেজের সব command **শুধু dev** এর জন্য। সব command project এর root folder থেকে চালাবেন।

| ফাইল | কাজ |
|---|---|
| `environments/dev.tfvars` | dev এর মান (IP, node, DB size) |
| `environments/dev.backend.hcl` | dev এর state কোথায় থাকবে |

> প্রথমবার হলে আগে [README](../README.md) এর "প্রথমবার Setup" করে নিন।

---

### ধাপ ১ — Dev এ switch

```bash
terraform init -reconfigure -backend-config=environments/dev.backend.hcl
```

### ধাপ ২ — কী বদলাবে দেখুন

```bash
terraform plan -var-file=environments/dev.tfvars
```

### ধাপ ৩ — তৈরি / আপডেট

```bash
terraform apply -var-file=environments/dev.tfvars
```

### ধাপ ৪ — kubectl connect

```bash
$(terraform output -raw kubeconfig_command)
kubectl get nodes
```

### Database password

```bash
aws secretsmanager get-secret-value \
  --secret-id "$(terraform output -raw rds_password_secret_arn)" \
  --query SecretString --output text
```

### সব মুছে ফেলা

```bash
terraform destroy -var-file=environments/dev.tfvars
```

> Dev কাজে না লাগলে মুছে রাখুন, মাসে ~$167 বাঁচবে।
