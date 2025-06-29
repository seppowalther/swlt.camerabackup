# 📹 swlt.camerabackup - CCTV Cloud Backup to AWS Glacier Deep Archive

This guide outlines how to set up a secure and cost-effective CCTV footage backup system using a Linux VPS and AWS S3 Glacier Deep Archive.

# 🎯 Why This Setup?

Learn why this cloud-based CCTV backup system was built and how it can help you avoid data loss, save on storage costs, and ensure long-term footage retention.

👉 [Visit my website](https://seppo.dev/reolink-and-aws-backup/)

## ✅ Requirements

- **Cloud VPS running Linux**  
  *(e.g., Hetzner CPX21 with Ubuntu 20.04)*
- **AWS S3 bucket**  
  *(Recommended region: `us-east-1` for lowest cost)*
- **CCTV cameras with native FTP upload support**  
  *(e.g., 10x Reolink cameras)*

---

## ⚙️ VPS Setup Instructions

### 1. Install & Configure `rclone`

Use `rclone` to sync files from the VPS to your AWS S3 bucket.

**Documentation:**
- [Rclone Installation Guide](https://rclone.org/install/)
- [Rclone AWS S3 Configuration](https://rclone.org/s3/)

> **Important:**  
> When setting up your S3 bucket, **select "Glacier Deep Archive"** as the storage class to avoid high storage costs.

---

### 2. Install & Configure ProFTPD

Set up an FTP server to receive footage directly from your CCTV cameras.

**Documentation:**  
[Hetzner ProFTPD Setup Guide](https://community.hetzner.com/tutorials/install-and-configure-proftpd/de?title=ProFTPD)

---

### 3. Create and Customize Scripts

Install the two shell scripts on your VPS:
- `awsscript.sh` – for syncing files to AWS
- `dailyscript.sh` – for daily automation tasks

> 🛠️ **Note:**  
> These scripts are just templates. You’ll need to customize them based on your directory paths, camera naming conventions, and S3 setup.

---

### 4. Automate Daily Sync with `cron`

Use `crontab` to run your daily sync script at a scheduled time (e.g., 11 PM daily):

```bash
crontab -e
```

Add the following line:

```bash
0 23 * * * /root/dailyscript.sh > /root/status_file.log 2>&1
```

---

## 🧾 Summary

With this setup:
- Your CCTV footage is securely uploaded via FTP to your VPS.
- Files are automatically backed up to AWS Glacier Deep Archive.
- Costs are minimized with scheduled syncs and cold storage.
