def test_docker_is_installed(host):
    # testen, ob das Paket "docker-ce" installiert ist
    docker_ce = host.package("docker-ce")
    assert docker_ce.is_installed

def test_docker_service_is_running(host):
    # testen, ob der Service "docker" läuft und verfügbar ist
    docker = host.service("docker")
    assert docker.is_running
    assert docker.is_enabled

def test_heroapp_container_is_running(host):
    # testen, ob der container mit dem Namen "my-hero-app" läuft
    my_hero_app = host.docker("my-hero-app")
    assert my_hero_app.is_running()

def test_heroapp_is_available_on_port_80(host):
    # testen, ob auf tcp://0.0.0.0:80 gehorcht wird
    server = host.socket("tcp://0.0.0.0:80")
    assert server.is_listening

    
