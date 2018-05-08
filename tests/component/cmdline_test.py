import pytest


@pytest.fixture
def app():
    """Get access to the app binary to allow running it for
    testing or to get the command to start it."""
    from .app import App
    return App()


def func(x):
    return x + 1


def test_answer():
    assert func(3) == 4


def test_help_message(app):
    """Verify that help option is displayed"""
    out = app.start(extra_args=['--help'])
    assert "Simple app demo with tests:" in out[1], "No help text in output"
    assert "USAGE: ./myapp [-h] [-l log-level]" in \
           out[1], "Wrong help output"