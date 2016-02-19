

docker build -t hehecloud/deis-phppgadmin .

docker run -it --name phppgadmin_v2.cmd.1 --rm -p 10801:8000 -e EXTERNAL_PORT=10801 -e HOST=10.171.22.25 hehecloud/deis-phppgadmin
