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


setup_everything(){
    cd .this/setup
    ansible-playbook setup.yml
}

run_for_first_time(){
    # Sets paths if running inside1
    echo running for first time

    # setup_ansible_parent_dir
    ln -srf ansible.sh ../../
}

run_in_Project_home(){
    # Sets paths if running at top!
    echo running from \$Project_home; echo
    setup_everything
}

detect_location