webappdir='/home/timm/git/roam-embedded'
proxydir='/home/timm/git/roam-embedded-proxy/GatewayApp'

echo -e "\e[1m\n === Building Webapp Image === \e[0m"
docker build \
  -t local/oxpd-web \
  -f webapp.df \
  $webappdir

echo -e "\e[1m\n === Running Maven Build For Proxy === \e[0m"
prevdir=$(pwd)
cd $proxydir
mvn clean install -DskipTests
cd $prevdir

echo -e "\e[1m\n === Building Proxy Image === \e[0m"
docker build \
  -t local/oxpd-proxy \
  -f proxy.df \
  $proxydir

echo -e "\e[1m\n === Starting Containers === \e[0m"
docker-compose up
