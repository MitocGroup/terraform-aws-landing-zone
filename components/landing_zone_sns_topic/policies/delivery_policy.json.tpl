{
  "http": {
    "defaultHealthyRetryPolicy": {
      "numRetries": ${numRetries},
      "numNoDelayRetries": ${numNoDelayRetries},
      "minDelayTarget": ${minDelayTarget},
      "maxDelayTarget": ${maxDelayTarget},
      "numMinDelayRetries": ${numMinDelayRetries},
      "numMaxDelayRetries": ${numMaxDelayRetries},
      "backoffFunction": "${backoffFunction}"
    },
    "disableSubscriptionOverrides": ${disableSubscriptionOverrides}
  }
}
