{{/*
Expand the name of the chart.
*/}}
{{- define "formsapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "formsapp.reactDeploymentLabel" -}}
app: {{- .Values.deploymentLabels.reactDeploymentLabel }}
tier: {{- printf "%s" "frontend" | quote }}
{{- end }}

{{- define "formsapp.djangoDeploymentLabel" -}}
app: {{- .Values.deploymentLabels.djangoDeploymentLabel }}
tier: {{- printf "%s" "backend" | quote }}
{{- end }}
{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "formsapp.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{- define "formsapp.djangoname" -}}
{{- if .Values.djangonameOverride }}
{{- .Values.djangonameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "formsapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "formsapp.labels" -}}

app: {{- printf "%s" .Values.label }}

helm.sh/chart: {{ include "formsapp.chart" . }}
{{ include "formsapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app: {{- printf "%s" .Values.selectorLabel }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "formsapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "formsapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "formsapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "formsapp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
