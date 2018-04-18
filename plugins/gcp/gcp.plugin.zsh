gssh() {
    eval `ssh-agent`
    ssh-add ~/.ssh/google_compute_engine
    gcloud compute ssh --ssh-flag="-A" "$@"
}
