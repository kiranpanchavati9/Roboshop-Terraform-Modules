resource "null_resource" "post-config" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/root/.ssh/roboshop-dev.pem")
    host        = var.private_ip
    timeout     = "5m"
  }

  provisioner "remote-exec" {

    inline = [

      # Wait for cloud-init/rpm locks
      "while sudo lsof /var/lib/rpm/.rpm.lock >/dev/null 2>&1; do sleep 5; done",

      # Wait for server boot completion
      "sleep 60",

      # Install required packages
      "sudo dnf install -y python3 python3-pip git",

      # Install ansible
      "sudo pip3 install ansible-core",

      # Install required ansible collection
      "ansible-galaxy collection install ansible.posix",

      # Refresh shell hash
      "hash -r",

      # Verify ansible
      "ansible --version",

      # Execute ansible-pull
      "ansible-pull -i localhost, -U https://github.com/kiranpanchavati9/Roboshop-Ansible-Template-New.git playbooks/${var.component_name}.yml -e env=dev -vvv"
    ]
  }
}