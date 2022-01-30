echo -e "--------client-side git progect initialization"
mkdir ../git_test_client_dir
cd ../git_test_client_dir
git init
echo 123 > test.txt
git add .
git commit -m "first commit"
git log

echo -e "\n\n--------server-side git progect initialization"
ssh f8@192.168.178.23 "mkdir git_test_server_dir; cd git_test_server_dir; git init --bare"

echo -e "\n\n--------add and push remote server origin"
git remote add origin ssh://f8@192.168.178.23:/home/f8/git_test_server_dir
git remote -v
git push origin master

echo -e "\n\n--------check list of commits on server"
ssh f8@192.168.178.23 "cd git_test_server_dir; git log"

echo -e "\n\n--------create and push second commit"
echo 321 > test2.txt
git add .
git commit -m "second commit"
git push origin master

echo -e "\n\n--------check list of commits on server"
ssh f8@192.168.178.23 "cd git_test_server_dir; git log"

echo -e "\n\n--------git clone from server to client"
cd ..
git clone ssh://f8@192.168.178.23:/home/f8/git_test_server_dir

echo -e "\n\n--------create and push third commit via cloned dir"
cd git_test_server_dir
echo 456 > test3.txt
git add .
git commit -m "third commit"
git remote -v
git push origin master

echo -e "\n\n--------check list of commits on server"
ssh f8@192.168.178.23 "cd git_test_server_dir; git log"

echo -e "\n\n--------go to original cient dir and list files"
cd ../git_test_client_dir
ls -1

echo -e "\n\n--------git pull and list files"
git pull origin master
ls -1

echo -e "\n\n--------remove:\n\tgit_test_client_dir\n\tgit_test_server_dir\n\tgit_test_server_dir (on server)"
cd ..
rm -rf ./git_test_client_dir
rm -rf ./git_test_server_dir
ssh f8@192.168.178.23 "rm -rf git_test_server_dir"
