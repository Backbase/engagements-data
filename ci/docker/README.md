# ENGAGEMENT DATA CONTENT

This container makes engagement data collections available in a volume.
The container can also be used in a kubernetes pod to copy the files to a kubernetes volume that is shared with other containers on the same pod, as described here https://kubernetes.io/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/.
This way, we can make the files available to another container on the same pod that invoke the java importing tool to configure environment.