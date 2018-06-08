from notebook.auth import passwd
c.NotebookApp.allow_origin="*"
c.NotebookApp.open_browser=False
c.NotebookApp.password = passwd("railsjupyter")
del passwd
c.NotebookApp.notebook_dir="/home/alan/data"
c.NotebookApp.tornado_settings={
        "headers": {
                "Content-Security-Policy": "frame-ancestors self http://localhost:3000; report-uri /api/security/csp-report"
            }
        }
