use crate::ics02_client::client_consensus::QueryClientEventRequest;
use crate::ics04_channel::channel::QueryPacketEventDataRequest;

/// Used for queries and not yet standardized in channel's query.proto
#[derive(Clone, Debug)]
pub enum QueryTxRequest {
    Packet(QueryPacketEventDataRequest),
    Client(QueryClientEventRequest),
}
