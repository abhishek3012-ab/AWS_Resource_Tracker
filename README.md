# AWS Resource Tracker 🚀

A Bash scripting project to track AWS resource usage from the Linux terminal. This script helps list important AWS resources and can be scheduled using a **Cron Job** to generate automatic reports without running the script manually every day.

## 📌 Project Overview

The AWS Resource Tracker is a shell script that uses the AWS CLI to collect information about AWS resources.

### AWS Services Tracked

- **Amazon S3:** Lists S3 buckets.
- **Amazon EC2:** Lists EC2 instances.
- **AWS Lambda:** Lists Lambda functions.
- **AWS IAM:** Lists IAM users.

## 🛠️ Technologies Used

- Linux
- Bash Scripting
- AWS CLI
- AWS IAM
- Cron Jobs
- `jq` (if used by the script)

## 📂 Project Structure

```text
AWS_Resource_Tracker/
├── README.md
└── aws_resource_tracker.sh
```

## ⚙️ Prerequisites

Before running this project, make sure you have:

1. An AWS account.
2. AWS CLI installed on your system.
3. AWS credentials configured using `aws configure`.
4. Required IAM permissions to list the AWS resources being tracked.
5. A Linux environment with Bash and Cron installed.
6. `jq` installed if your script uses it.

## 🚀 How to Run the Script

### 1. Clone the Repository

```bash
git clone https://github.com/abhishek3012-ab/AWS_Resource_Tracker.git
```

Navigate to the project directory:

```bash
cd AWS_Resource_Tracker
```

### 2. Configure AWS CLI

```bash
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, default region, and output format when prompted.

**Security note:** Never upload AWS access keys, secret keys, or other credentials to GitHub. Use an IAM identity with only the permissions required by the script.

### 3. Make the Script Executable

Run the following command in the project directory:

```bash
chmod +x aws_resource_tracker.sh
```

### 4. Execute the Script

```bash
./aws_resource_tracker.sh
```

The script will display information about the AWS resources it tracks, provided the AWS credentials and permissions are configured correctly.

---

## ⏰ Automate AWS Resource Tracking Using Cron Jobs

A Cron Job allows you to run a script automatically at a scheduled time. In this project, Cron can execute the AWS Resource Tracker every day and save its output to a log file.

### 🔔 Step 1: Make the Script Executable

Grant permission to execute the script:

```bash
chmod +x aws_resource_tracker.sh
```

### 🔔 Step 2: Find Your Absolute Paths

Cron Jobs may run with a different environment from your normal terminal. Use absolute paths instead of relative paths such as `./` or `~/`.

Find the directory containing your script:

```bash
pwd
```

Example output:

```text
/home/abhishek/scripts
```

Your full script path would then be:

```text
/home/abhishek/scripts/aws_resource_tracker.sh
```

Find the locations of the AWS CLI and `jq`:

```bash
which aws
which jq
```

Example output:

```text
/usr/local/bin/aws
/usr/bin/jq
```

Your actual paths may be different. If a command is not found, install it or locate its correct path.

### 🔔 Step 3: Update the Script for the Cron Environment

Open the script:

```bash
nano aws_resource_tracker.sh
```

Add the following line immediately after `set -x`:

```bash
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"
```

This helps Cron locate the required commands.

If `aws` or `jq` is installed in a different directory, include that directory in the PATH.

Save the file and exit Nano:

- Press `Ctrl + O` to save.
- Press `Enter` to confirm.
- Press `Ctrl + X` to exit.

### 🔔 Step 4: Open the Crontab Editor

Run:

```bash
crontab -e
```

This opens the Cron configuration for your current Linux user.

**Important:** Use the same user account that has access to your configured AWS credentials. Cron does not automatically load all the environment settings from your interactive terminal.

### 🔔 Step 5: Schedule the Daily AWS Report

Add the following line at the bottom of the crontab file. Replace the example paths with your actual paths.

```cron
0 14 * * * /home/abhishek/scripts/aws_resource_tracker.sh > /home/abhishek/scripts/aws_tracker.log 2>&1
```

#### Understanding the Cron Expression

| Field | Value | Meaning |
|---|---|---|
| Minute | `0` | At minute zero |
| Hour | `14` | At 2:00 PM |
| Day | `*` | Every day of the month |
| Month | `*` | Every month |
| Day of Week | `*` | Every day of the week |

**Result:** The script runs every day at **2:00 PM according to the system's local time**.

#### Understanding the Output Redirection

```bash
> /home/abhishek/scripts/aws_tracker.log 2>&1
```

- `>` saves standard output to the log file, replacing its previous contents each time.
- `2>&1` redirects error output to the same destination.
- `aws_tracker.log` lets you review the report and troubleshoot failures.

Because the script uses `set -x`, the log can also contain command execution traces.

### 🔔 Step 6: Save and Verify the Cron Job

If you are using Nano, save and exit:

1. Press `Ctrl + O`.
2. Press `Enter`.
3. Press `Ctrl + X`.

Verify that your Cron Job is scheduled:

```bash
crontab -l
```

You should see your scheduled command listed.

Check the generated report after the scheduled run:

```bash
cat /home/abhishek/scripts/aws_tracker.log
```

To test the logging setup immediately, run the script manually:

```bash
/home/abhishek/scripts/aws_resource_tracker.sh > /home/abhishek/scripts/aws_tracker.log 2>&1
```

### 🔔 Step 7: Troubleshooting

If the report is not generated correctly, check the following:

- **AWS CLI not found:** Verify the AWS CLI path and update PATH.
- **Permission denied:** Run `chmod +x aws_resource_tracker.sh`.
- **AWS authentication errors:** Check the credentials and AWS identity used by the scheduled job.
- **Access denied errors:** Verify that the IAM identity has the required read permissions.
- **Empty or outdated report:** Check the log file and confirm the selected AWS region.
- **Cron is not running:** Check the Cron service status using the appropriate command for your Linux distribution.

For Ubuntu, you can check the service with:

```bash
sudo systemctl status cron
```

If you use Amazon Linux or another distribution, the service name or management command may differ.

---

## 🔐 Security Best Practices

- Never commit AWS access keys or secret keys to GitHub.
- Prefer IAM roles or temporary credentials when available.
- Grant only the minimum permissions needed to list resources.
- Keep log files private because they may contain infrastructure details.
- Remember that the script tracks resource information; it does not automatically calculate AWS billing costs unless billing-related functionality is added.

## 🎯 Learning Outcomes

By building this project, I practised:

- Writing and executing Bash scripts.
- Using AWS CLI commands to inspect AWS resources.
- Working with Linux file permissions.
- Scheduling recurring tasks with Cron.
- Redirecting command output and errors to log files.
- Troubleshooting environment variables and AWS permissions.

## 👨‍💻 Author

**Abhishek Birajdar**

GitHub: [abhishek3012-ab](https://github.com/abhishek3012-ab)

⭐ If you find this project useful, consider giving the repository a star!

⭐ If you find this project useful, consider giving the repository a star!
