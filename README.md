# 🦅 Container Security Falcon  
**Runtime Protection & Shift-Left Security for Kubernetes | EKS + Falco + Trivy**

[![Trivy](https://img.shields.io/badge/Trivy-0.50+-blue?logo=aquasecurity)](https://aquasecurity.github.io/trivy/)
[![Falco](https://img.shields.io/badge/Falco-0.37+-purple?logo=falcosecurity)](https://falco.org/)
[![EKS](https://img.shields.io/badge/AWS_EKS-1.28-orange?logo=amazon-aws)](https://aws.amazon.com/eks)

![Falco Dashboard](docs/dashboard.png)

## 🔑 Key Features
- **Pre-Deployment Scans**: Block CVSS ≥7.0 images in CI/CD
- **Runtime Protection**: Detect cryptominers, shells, privilege escalation
- **Zero-Trust Networking**: Kubernetes Network Policies
- **Compliance**: CIS Kubernetes Benchmark, GDPR Art.32

## 🛠️ Tech Stack
| Component       | Tools Used                          |
|-----------------|-------------------------------------|
| Orchestration   | EKS, Kops                           |
| Scanning        | Trivy, Clair, ECR Scanning          |
| Runtime Security| Falco, eBPF                         |
| CI/CD           | Jenkins, Argo CD                    |
| Monitoring      | Prometheus, Grafana, AWS CloudWatch |

## 📊 Security Metrics
```bash
# Sample Trivy Output
CRITICAL: 12 vulnerabilities found
HIGH: 23 vulnerabilities found
┌───────────────┬───────────────┬───────────────────┐
│   LIBRARY     │ VULNERABILITY │     SEVERITY      │
├───────────────┼───────────────┼───────────────────┤
│ openssl       │ CVE-2023-3817 │ CRITICAL (9.8)    │
│ python        │ CVE-2023-3269 │ HIGH (7.5)        │
└───────────────┴───────────────┴───────────



---


# 1. Deploy EKS cluster
cd infrastructure
terraform apply -auto-approve

# 2. Apply security policies
kubectl apply -f kubernetes/network-policies/
kubectl apply -f kubernetes/psp/

# 3. Run CI/CD pipeline
jenkins build -f ci-cd/Jenkinsfile

# 4. Monitor runtime threats
kubectl logs -l app=falco --tail=50 -f

### 💡 **Key Skills Demonstrated**  
1. **Kubernetes Hardening**: Network policies, Pod Security Admission  
2. **Shift-Left Security**: Trivy in CI, immutable ECR tags  
3. **Runtime Protection**: Custom Falco rules, eBPF instrumentation  
4. **Incident Response**: Automated playbooks, forensic capture  
5. **Compliance**: CIS benchmarks, GDPR alignment  

Add **screenshots** of:
- Trivy scan reports blocking a build  
- Falco alerts in Grafana  
- Network policy violation logs  

This project shows you can handle the **full container lifecycle security** - exactly what employers need for cloud-native roles! 🚀