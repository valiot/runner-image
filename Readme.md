Valiot's Self-hosted runner image

The [default image](https://github.com/actions/actions-runner-controller/blob/master/docs/about-arc.md#software-installed-in-the-runner-image) comes very slim, we need to add some packages.

Custom packages added
- yarn
- kubectl
- [Cypress Dependencies](https://docs.cypress.io/guides/continuous-integration/introduction#UbuntuDebian)

## Version
1.0.0

## Build and Push
```bash
docker buildx build -t ghcr.io/valiot/runner-image:${version} . --platform=linux/amd64,linux/arm64 --push
```

If you have issues building the image try adding `--no-cache` to the docker command

Read more at:
- https://github.com/actions/setup-node/issues/182
- https://github.com/actions/runner-images
- https://github.com/catthehacker/docker_images
