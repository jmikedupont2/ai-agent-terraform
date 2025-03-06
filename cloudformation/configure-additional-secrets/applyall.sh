
for x in `find . -maxdepth 1  -type d `;
	 
do pushd $x;
   terraform init ;
   terraform apply -auto-approve
   popd;
done

