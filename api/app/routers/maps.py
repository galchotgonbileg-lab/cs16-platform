pyfrom fastapi import APIRouter

router = APIRouter()


@router.get("/")
def maps():
    return [
        "de_dust2",
        "de_inferno",
        "de_nuke",
        "de_train",
    ]