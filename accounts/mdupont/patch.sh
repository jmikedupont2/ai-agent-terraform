terraform plan -no-color  >  plan.txt
grep create  plan.txt | cut -d" " -f4  | grep module > targets.txt
for x in `cat targets.txt`; do echo " --target '$x'"; done  | sed -e "s;\n;;g" | tr -d '\n'^J^J  > tt 2>tt2
