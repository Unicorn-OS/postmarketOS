# This script will detect whether it's running for the first time, within `.this` and set paths

detect_location(){
    at=$(basename `pwd`)
    help_wrong_path="This script is not in a proper path, please run it from this to initialize: \`cd .this; ./ansible.sh\`"

    # Run inside Project/home
    if [ -d ansible ]; then
        verify_ansible_and_run
    # Run inside ansible/.this utility directory
    elif [ "$at" == ".this" ]; then
        run_for_first_time
    # Cannot run, location is wrong!
    else
        echo $help_wrong_path
    fi
}

verify_ansible_and_run(){
    # Verifies that it's contains a valid ansible project!
    cd ansible
    if [ -d .this ] && [ -f uni ];then
        # Debug
        # ls -alh
        echo "Ansible structure is correct"; echo
        run_in_Project_home
    fi
    # back to parent dir
    cd ~-
}

setup_ansible(){
    cd ansible/.this
    ansible-playbook init.yml
}

setup_inventory(){
    # Copy Inventory/.example to $new_name if it doesn't exist
    new_name="test"
    echo "inventory/$new_name" >.this/.gitignore

    cd .this/inventory/
    [ ! -d "$new_name" ] && cp -r .example $new_name
    # help message
    echo "Inventory copied to \`.this/inventory/$new_name\`"; echo
    cd ~-
}

setup_ansible_cfg(){
    # We can make this more complex in the future! But for now just symlink:
    ln -srf .this/ansible.cfg .
    echo setup ansible.cfg;echo
}

setup_dependencies(){
    ansible-playbook
}

setup_everything(){
    setup_inventory
    setup_ansible_cfg
    setup_dependencies
}

run_for_first_time(){
    # Sets paths if running inside1
    echo running for first time

    # setup_ansible_parent_dir
    ln -srf ansible.sh ../../
    # Run in $Project_home as normal
    cd ../../
    echo Running in $Project_home
    run_in_Project_home
}

run_in_Project_home(){
    # Sets paths if running at top!
    echo running from \$Project_home; echo
    setup_everything
}

detect_location