# 🔴 Prod Environment

এই পেজের সব command **শুধু prod** এর জন্য। সব command project এর root folder থেকে চালাবেন।

| ফাইল | কাজ |
|---|---|
| `environments/prod.tfvars` | prod এর মান (IP, node, DB size) |
| `environments/prod.backend.hcl` | prod এর state কোথায় থাকবে |

> প্রথমবার হলে আগে [README](../README.md) এর "প্রথমবার Setup" করে নিন।

---

### ধাপ ০ — প্রথমবার শুধু একবার

`environments/prod.tfvars` এ আপনার office/VPN এর IP বসান:

```bash
curl ifconfig.me          # আপনার IP দেখাবে
```

```hcl
eks_public_access_cidrs = ["203.0.113.10/32"]   # শেষে /32 দিন
```

### ধাপ ১ — Prod এ switch

```bash
terraform init -reconfigure -backend-config=environments/prod.backend.hcl
```

### ধাপ ২ — কী বদলাবে দেখুন

```bash
terraform plan -var-file=environments/prod.tfvars
```

> ⚠️ Prod এ `plan` এর শেষ লাইন মন দিয়ে পড়ুন। `destroy` এর সংখ্যা 0 না হলে apply দেওয়ার আগে কারণটা বুঝে নিন।

### ধাপ ৩ — তৈরি / আপডেট

```bash
terraform apply -var-file=environments/prod.tfvars
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

> Prod এ database এর `deletion_protection` চালু আছে, তাই ভুল করে database মুছে যাবে না।
