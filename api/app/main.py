from fastapi import FastAPI

from app.routers.health import router as health_router
from app.routers.servers import router as servers_router
from app.routers.players import router as players_router
from app.routers.maps import router as maps_router

app = FastAPI(
    title="CS16 Platform Pro",
    version="11.0.0",
)

app.include_router(health_router)
app.include_router(servers_router, prefix="/servers", tags=["servers"])
app.include_router(players_router, prefix="/players", tags=["players"])
app.include_router(maps_router, prefix="/maps", tags=["maps"])