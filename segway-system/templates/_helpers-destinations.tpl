{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "segway-system.destinations.fullname" -}}
{{- if .Values.destinations.fullnameOverride }}
{{- .Values.destinations.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (printf "%s-%s" .Chart.Name "destinations") .Values.destinations.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "segway-system.destinations.labels" -}}
helm.sh/chart: {{ include "segway-system.chart" . }}
{{ include "segway-system.destinations.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "segway-system.destinations.selectorLabels" -}}
{{ include "segway-system.selectorLabels" . }}
app.kubernetes.io/compoennt: destinations
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "segway-system.destinations.serviceAccountName" -}}
{{- if .Values.destinations.serviceAccount.create }}
{{- default (printf "%s-%s" (include "segway-system.fullname" .) "destinations" ) .Values.destinations.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.destinations.serviceAccount.name }}
{{- end }}
{{- end }}
