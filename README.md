# dps-items

Item rules for ox_inventory: locked items, glovebox seats and an exploit watch.

## What it is for

Stock ox_inventory lets a player drop or hand over anything, including an ID card. It lets a
back-seat passenger open the glovebox. It also says nothing when someone moves items faster
than a person can, or when a large pile of cash appears. This script adds three rules that fix
those gaps and tell staff when something looks wrong.

## What it does

- **Item lock.** ID card, driver licence, weapon licence and lawyer pass stay with their owner.
  They cannot be dropped, given away or taken by another player. Any item with `locked = true`
  in its metadata is locked the same way. The owner can still put a locked item in a stash,
  house, trunk or glovebox.
- **Glovebox seats.** Inside a vehicle, only the driver and the front passenger can open the
  glovebox.
- **Exploit watch.** It flags three things:
  - 25 inventory moves by one player inside 3 seconds.
  - 250,000 or more in cash handed to another player, or created by a script in one go.
  - A weapon serial number created a second time in a different inventory.
- A blocked player sees a short message. A flag goes to the server console and to the ox_lib
  logger. The watch only reports. It does not block or punish.
- Staff with the `dps.items.admin` ace skip the item lock and the glovebox rule.

## On its own, and with other scripts

**With ox_inventory or dps-inventory.** This is the hard requirement. All three rules run on
ox_inventory hooks (`swapItems`, `openInventory`, `createItem`). No inventory file is edited, so
an inventory update does not remove the rules.
[dps-inventory](https://github.com/DaemonAlex/dps-inventory) runs under the ox_inventory name
and works the same way.

**With job scripts that hand out gear.** A police, ambulance or other job script can add
`locked = true` to the metadata of an item it issues. That item then cannot be dropped or
passed to another player. Weapons with the serial `POL` are left out of the duplicate serial
check.

**With a logging service.** Flags go through `lib.logger`, so they land wherever your ox_lib
logging is set to send them. Set `inventory:loglevel 2` in your cfg if you also want
ox_inventory to log which script added or removed items.

## Requirements

- `ox_lib`
- `ox_inventory`, or dps-inventory

## Install

1. Put the folder in your resources and add `ensure dps-items` after `ox_inventory`.
2. Give staff the ace: `add_ace group.admin dps.items.admin allow`.
3. Check that the item names in `Config.Lock.items` match your `data/items.lua`.

## Configuration

`config.lua`:

| Setting | Meaning |
|---|---|
| `Config.AdminAce` | Ace that skips the item lock and the glovebox rule. |
| `Config.Lock.items` | Item names that are always locked to their holder. |
| `Config.Lock.metaKey` | Metadata key that locks any item when set to `true`. Default `locked`. |
| `Config.Glovebox.seats` | Seats that may open the glovebox. `-1` is the driver, `0` the front passenger. |
| `Config.Watch.burstCount` | Moves inside the window before a player is flagged. |
| `Config.Watch.burstWindowMs` | Length of that window in milliseconds. |
| `Config.Watch.bigCash` | Cash amount that is flagged when handed over or created. |
| `Config.Watch.cashItems` | Item names that count as cash. |
| `Config.Watch.cooldown` | Seconds between repeat flags of the same kind for the same player. |
| `Config.Text` | The messages a blocked player sees. |

## Recent changes

- **12 November 2026.** README added.
- **4 November 2026.** Script written: item lock, glovebox seats and exploit watch.

## Author

Made by [DaemonAlex](https://github.com/DaemonAlex) for DelPerroSands.

## Other DPS scripts

All of these are made for DelPerroSands and run together on one Qbox server. Each one works on
its own. The ones marked "pairs with" do more when both are running.

| Script | What it does |
|---|---|
| [dps-inventory](https://github.com/DaemonAlex/dps-inventory) | The inventory: ox_inventory with equipment slots, backpacks, armour plates and a self status panel, in the DelPerroSands colours. |
| [dps-medical](https://github.com/DaemonAlex/dps-medical) | Patient records, illness and diagnostic tests. A companion to wasabi_ambulance. Pairs with dps-inventory: symptoms and diagnoses show on the status panel. |
| [dps-insurance](https://github.com/DaemonAlex/dps-insurance) | Ties m-Insurance into the MDT, impound, hospital and medical chart. Pairs with dps-medical. |
| [dps-studio](https://github.com/DaemonAlex/dps-studio) | Build rooms, doors and portals in game from one panel (`/studio`), with owners and managers so staff do not have to support them. |
| [dps-shops](https://github.com/DaemonAlex/dps-shops) | Shop clerks who greet and react to a robbery, then player-owned shops. |
| [dps-fleet](https://github.com/DaemonAlex/dps-fleet) | Vehicle browser and workshop on one panel: extras, liveries and mods for emergency vehicles. |
| [dps-parking](https://github.com/DaemonAlex/dps-parking) | Parking with valet, impound, violations and reserved spots. |
| [dps-vehiclepersistence](https://github.com/DaemonAlex/dps-vehiclepersistence) | Vehicles stay where they were parked. Pairs with dps-parking. |
| [dps-towjob](https://github.com/DaemonAlex/dps-towjob) | Queue-based tow job with jg-mechanic integration. |
| [dps-services](https://github.com/DaemonAlex/dps-services) | Request a tow and follow it live on the lb-phone and lb-tablet. Pairs with dps-towjob. |
| [dps-autoshops](https://github.com/DaemonAlex/dps-autoshops) | Self-service repair shops when no mechanic is on duty. |
| [dps-cityworker](https://github.com/DaemonAlex/dps-cityworker) | City infrastructure job and career. |
| [dps-ainpcs](https://github.com/DaemonAlex/dps-ainpcs) | NPCs you can talk to, with trust, quests and intel. |
| [dps-badpeds](https://github.com/DaemonAlex/dps-badpeds) | Police interaction with NPCs: stops, arrests, intel and jail records. |
| [dps-gangwars](https://github.com/DaemonAlex/dps-gangwars) | Ambient gang NPCs, territory population and war reinforcements. |
| [dps-rotations](https://github.com/DaemonAlex/dps-rotations) | Moves dealers, harvests and other spots on a fixed schedule. |
| [dps-trains](https://github.com/DaemonAlex/dps-trains) | The train system. Pairs with dps-trains-stock, dps-traintools and dps-transitapp. |
| [dps-transitapp](https://github.com/DaemonAlex/dps-transitapp) | Live train arrival boards on the lb-phone. |
| [dps-faceplant](https://github.com/DaemonAlex/dps-faceplant) | City help, reports and staff tools on the lb-phone and lb-tablet. |
| [dps-chat](https://github.com/DaemonAlex/dps-chat) | A command box for voice-only servers. No chat feed. |
| [dps-filmmode](https://github.com/DaemonAlex/dps-filmmode) | One key hides every HUD layer and gives a smooth free camera for recording. |
