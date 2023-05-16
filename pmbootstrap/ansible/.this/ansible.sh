# This script will detect whether it's running for the first time, within `.this` and set paths

detect_location(){
    at=$(basename `pwd`)
    help_wrong_path="This script is not in a proper path, please run it from this to initialize: \`cd .this; ./ansible.sh\`"

    # Run inside Project/home
    if [ -d ansible ]; then
        verify_ansible_and_run
    # Run inside ansible/.this utility directory
    elif [ "$at" == ".this" ]; then
        running_for_first_time
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
        echo "Ansible looks correct"
        running_in_project
    fi
    # back to parent dir
    cd ~-
}

setup_ansible(){
    cd ansible/.this
    ansible-playbook init.yml
}

setup_inventory(){
    new_name="test"
    echo "inventory/$new_name" >.this/.gitignore

    # Copy .example to test if it doesn't exist
    cd .this/inventory/
    [ ! -d "$new_name" ] && cp -r .example $new_name
    cd -
}

setup_everything(){
    setup_inventory
}

running_for_first_time(){
    # Sets paths if running inside1
    echo running for first time

    # setup_ansible_parent_dir
    ln -srf ansible.sh ../../
}

running_in_project(){
    # Sets paths if running at top!
    echo running in project
    setup_everything
}

detect_location