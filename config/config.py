from notebook.auth import passwd
c.NotebookApp.allow_origin="*"
c.NotebookApp.open_browser=False
c.NotebookApp.disable_check_xsrf = True
# c.NotebookApp.password = passwd("railsjupyter")
c.NotebookApp.token = ""
c.Application.log_level="DEBUG"
c.NotebookApp.base_url = '/notebooks'
del passwd
c.NotebookApp.notebook_dir="/data/rails"
c.NotebookApp.tornado_settings={
        "headers": {
                "Content-Security-Policy": "report-uri /api/security/csp-report"
            }
        }
