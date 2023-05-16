dependency(){
if [[ -d dependency ]]; then
cd dependency
./init
cd -
fi
}


update(){
if [ -f "update.yml" ]; then
    ansible-playbook update.yml
fi
}

test(){
ansible -m ping test
}

main(){
dependency
setup_inventory
update
#test
}

main
