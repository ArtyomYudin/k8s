{{/*
Expand the name of the chart.
*/}}
{{- define "modx.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "modx.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a fully qualified modx name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}

{{- define "modx.php-fpm.fullname" -}}
{{- if .Values.phpfpm.fullnameOverride -}}
{{- .Values.phpfpm.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.phpfpm.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.phpfpm.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified nginx name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}

{{- define "modx.nginx.fullname" -}}
{{- if .Values.nginx.fullnameOverride -}}
{{- .Values.nginx.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.nginx.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.nginx.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Create a fully qualified label-ns name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}

{{- define "modx.labelnamespace.fullname" -}}
{{- if .Values.labelnamespace.fullnameOverride -}}
{{- .Values.labelnamespace.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.labelnamespace.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.labelnamespace.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}



{{/*
Common labels
*/}}
{{- define "modx.common.matchLabels" -}}
app: {{ template "modx.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{- define "modx.common.metaLabels" -}}
chart: {{ template "modx.chart" . }}
heritage: {{ .Release.Service }}
{{- end -}}

{{- define "modx.php-fpm.labels" -}}
{{ include "modx.php-fpm.matchLabels" . }}
{{ include "modx.common.metaLabels" . }}
{{- end -}}

{{- define "modx.php-fpm.matchLabels" -}}
component: {{ .Values.phpfpm.name | quote }}
{{ include "modx.common.matchLabels" . }}
{{- end -}}

{{- define "modx.nginx.labels" -}}
{{ include "modx.nginx.matchLabels" . }}
{{ include "modx.common.metaLabels" . }}
{{- end -}}

{{- define "modx.nginx.matchLabels" -}}
component: {{ .Values.nginx.name | quote }}
{{ include "modx.common.matchLabels" . }}
{{- end -}}

{{- define "modx.labelnamespace.labels" -}}
{{ include "modx.labelnamespace.matchLabels" . }}
{{ include "modx.common.metaLabels" . }}
{{- end -}}

{{- define "modx.labelnamespace.matchLabels" -}}
component: {{ .Values.labelnamespace.name | quote }}
{{ include "modx.common.matchLabels" . }}
{{- end -}}


{{/*
Selector labels
*/}}
{{- define "modx.selectorLabels" -}}
app.kubernetes.io/name: {{ include "modx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}








{{/*
Create the name of the service account to use for the phpfpm component
*/}}
{{- define "modx.php-fpm.serviceAccountName" -}}
{{- if .Values.serviceAccounts.phpfpm.create -}}
    {{ default (include "modx.php-fpm.fullname" .) .Values.serviceAccounts.phpfpm.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.phpfpm.name }}
{{- end -}}
{{- end -}}


{{/*
Create the name of the service account to use for the nginx component
*/}}
{{- define "modx.nginx.serviceAccountName" -}}
{{- if .Values.serviceAccounts.nginx.create -}}
    {{ default (include "modx.nginx.fullname" .) .Values.serviceAccounts.nginx.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.nginx.name }}
{{- end -}}
{{- end -}}


{{/*
Create the name of the service account to use for the label-ns component
*/}}
{{- define "modx.labelnamespace.serviceAccountName" -}}
{{- if .Values.serviceAccounts.labelnamespace.create -}}
    {{ default (include "modx.labelnamespace.fullname" .) .Values.serviceAccounts.labelnamespace.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.labelnamespace.name }}
{{- end -}}
{{- end -}}


{{/*
Kubernetes version
Built-in object .Capabilities.KubeVersion.Minor can provide non-number output
For examples:
- on GKE it returns "18+" instead of "18"
- on EKS it returns "20+" instead of "20"
*/}}
{{- define "chart.KubernetesVersion" -}}
{{- $minorVersion := .Capabilities.KubeVersion.Minor | regexFind "[0-9]+" -}}
{{- printf "%s.%s" .Capabilities.KubeVersion.Major $minorVersion -}}
{{- end -}}


{{/*
Define the modx.namespace template if set with forceNamespace or .Release.Namespace is set
*/}}
{{- define "modx.namespace" -}}
{{- if .Values.forceNamespace -}}
{{ printf "namespace: %s" .Values.forceNamespace }}
{{- else -}}
{{ printf "namespace: %s" .Release.Namespace }}
{{- end -}}
{{- end -}}