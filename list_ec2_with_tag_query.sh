
aws ec2 describe-instances \
--filters Name=tag:ENV,Values=Development \
--query Reservations[*].Instances[*].[InstanceId] \
--output text

aws ec2 describe-instances \
--filters Name=tag:ENV,Values=Development \
--query Reservations[*].Instances[*].[ImageId] \
--output text
