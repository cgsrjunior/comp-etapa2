
#!/bin/bash
for f in E2/*
do
   ./etapa2 < "$f"
   echo "$f:$?"
done
