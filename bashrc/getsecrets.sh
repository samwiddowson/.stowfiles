RAW_DSPT_SECRETS=$(aws secretsmanager get-secret-value \
    --secret-id arn:aws:secretsmanager:eu-west-2:730319765130:secret:dspt-nonprod-dev/deployment-HpZD4M \
    --output text \
    --query SecretString)

echo "$RAW_DSPT_SECRETS" | jq -r 'to_entries[] | "export \(.key)=\(.value)"'
