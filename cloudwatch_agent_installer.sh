1. AWS Linux 2 makinaların `sudo yum install amazon-cloudwatch-agent -y`
2. IAM Role'u yarat EC2'ler için.
	- Role içeriği: CloudWatchAgentServerPolicy 
3. bu yarattığın rolu aws cli üzerinden ec2 makinasına ata
Örnek:
```
aws ec2 associate-iam-instance-profile \
    --instance-id i-07a3f3e2ced4bf503 \
    --iam-instance-profile Name="InstalledCloudWatchAgentRole"
```

4. Sonrasında makinada cloudwatch agent configuration wizard çalıştırıp global config dosyasını yaratıyorsun.

Örnek:
```
{
        "agent": {
                "metrics_collection_interval": 60,
                "run_as_user": "cwagent"
        },
        "metrics": {
                "append_dimensions": {
                        "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
                        "ImageId": "${aws:ImageId}",
                        "InstanceId": "${aws:InstanceId}",
                        "InstanceType": "${aws:InstanceType}"
                },
                "metrics_collected": {
                        "disk": {
                                "measurement": [
                                        "used_percent"
                                ],
                                "metrics_collection_interval": 60,
                                "resources": [
                                        "*"
                                ]
                        },
                        "mem": {
                                "measurement": [
                                        "mem_used_percent"
                                ],
                                "metrics_collection_interval": 60
                        }
                }
        }
}
```

5. bu yarattığı dosyayı sistemde 
`/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json` bu şekilde kaydediyorsun. 
6. sonra servisi baştan başlatıyorsun
`sudo amazon-cloudwatch-agent-ctl -a stop`
`sudo amazon-cloudwatch-agent-ctl -a start`
