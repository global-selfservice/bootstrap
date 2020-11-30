terraform([
    aws: [role: "jenkins-devops", account: "435559816706"],
    stages: [
        [name: "Dev"],
        [name: "Live", aws: [account: "191125840152"], extra: [workspace: "default"]]
    ]
])
