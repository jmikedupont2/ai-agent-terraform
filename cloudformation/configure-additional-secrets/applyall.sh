
for x in *;
do pushd $x;
   terraform init ;
   terraform apply -auto-approve
   popd;
done
