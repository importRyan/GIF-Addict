| [About](#about)  | [Project Contents](#repo-contents) | [Faults & Next Steps](#faults-and-next-steps) | [Assignment](#assignment-recap) | [Test Flight / Build Instructions](#installation) |
| ------------- | ------------- |  ------------- | ------------- | ------------- | 

#  GIF Addict (Interview Project)

https://user-images.githubusercontent.com/78187398/153201092-4d865592-49c8-4e96-b55a-04d7149ea8d1.mp4

## About

#### Premise
Sharing funny GIFs has long been one of the killer features of the internet, MMS, and all the MySpace children like Facebook. Yet, the actual process of searching for a GIF is often a lonesome scrolling task for one.

#### Weekend Product
Per assignment, GIF Addict hits the GIPHY API. It also explores SharePlay as a way to socially scroll the hoards of GIFs with friends. Try to guess the search term your friend used for their favorite pick.

---

## Repo Contents

This simple "display images" app spans a few small packages. The logic, persistence, and remote service packages do not reference each other. The `Addictive Services` package resolves dependencies for the macOS app.

| Package  | Utility | Dependencies |
|:-------------|:-------------|:-------------|
| **Addiction**  | Logic  | `Combine`, `SharePlay` |
| **AddictiveCoreData**  | Cloud and in-memory stores (local content service)  | `CoreData` |
| **Giphy**  | Remote mirthful content service  | `Combine`, signature of `URLSession.DataTaskPublisher` |
| **Addictive** Services | Composes dependencies  | Addiction, AddictiveCoreData, Giphy, `Combine` |
| **SharedUI**  | Fonts, colors, conveniences  | SwiftUI |
| **GIF Addict App** | Mac only  | Addiction, AddictiveServices, SharedUI, `Nuke`, `AppKit`, `Combine`, `SwiftUI` |


### Directories

```
/Addiction
```
 *  `/Protocols`. Abstracted `ContentService`s, of both remote and local derivatives, deliver search queries to the app. 
 * `/UseCases` Creating a search, listing results, rating a GIF, and coordinating SharePlay are each separate `UseCase` protocols.
 * `/App` Simple objects that privately wire up services and vend use cases.
 * Testing strategy: unit tests and use case integration tests

```
/AddictiveServices
```
 * Maps package and logic models
 * Testing strategy: Integration tests

```
/AddictiveCoreData
```
 * Simplistic schema and API similar to Giphy
 * NSManagedObjects are not exposed publicly
 * Testing strategy: Unit and in-memory behavioral tests

```
/Giphy
```
 * Testing strategy: unit tests, mock URLSession, and live API tests

```
/SharedUI
```
 * Contains SwiftUI conveniences, .colorsets and thematic/dyslexic fonts, such as the colorful Gilbert SBIX font

```
/Shared (macOS / iPad app)
```
 * SwiftUI views depend upon generic use case protocols
 * Single-scene app, with three `/Screens` (splash, main, and focus popover)
 * A screen arranges `/Views`, such as search bar or content grid
 * `/Components` are reusable base views, like a rating button, without any protocol dependencies
 * Localization for English and Chinese
 * Testing strategy: View model unit tests, basic UI tests
 
```
Deployment
```
  * Automatic to TestFlight via Xcode Cloud workflow
  
---

## Faults and Next Steps

To paraphrase Graham McCarthy, Rome wasn't build by some guy in a weekend. Some unfinished business and next steps include:

1. Performance improvements
- Image prefetching ahead of scroll direction to remove "blank spaces" loading delays on fast scroll
- Memory footprint builds past expectations for in memory caches (URLSession, Nuke). Resetting the view hierarchy helps, suggesting some interplay with LazyVGrid's recycling strategy and Nuke's video layers. Investigation needed.
- Likely related to #2, leaks appear on Apple Silicon, but not Intel, with same OS and Xcode environment. (12.3 beta 21E5196i)

2. SharePlay
- Refactor it into a testable service package
- Prepare for users on multiple versions: wrap model in versioning containers
- Explore gamification modes
- Track history of all GIFs shared
- Display friend's ratings too
- Mini map of position in results scroll / "follow" specific users as they scroll

3. Testing
- Round out gaps in testing battery, particularly logic layer and performance testing of collection view scrolls

4. Accessibility
- Dyslexia-friendly font replacements
- VoiceOver testing and adaptations
 
---

## Assignment Recap

Create a macOS or iOS app that can search, save, rank, and sort animated GIFs. Deliver at least one day prior to interview as a GitHub repo.

#### Scope & Requirements
- [x] Use Giphy's API to search for tags and display a paged list of GIFs
- [x] Tap on a GIF to focus, display more info
- [x] Rate the GIF and sort a list by rating
- [x] UI: no specific requirements, but use SwiftUI
- [x] Provide installation instructions (to run on Monterey, see below)
- [x] Write tests

Nice to haves:
- [x] Persist beyond local device
- [x] Use architectural patterns
- [x] Use a package manager
- [ ] Use Storyboards (if not SwiftUI)
- [ ] Optimize scrolling performance of the GIF list

---

## Installation

#### Test Flight (macOS only)

> [Public link](https://testflight.apple.com/join/YVu54c8W)

#### Compile Yourself (macOS only)
1. Clone the repo
2. Open `/GIF Addict/GIF Addict.xcproj`
3. Use Xcode 13 on Monterey 12.1+
4. Use `Scheme: GIF Addict macOS`

Warning: This scheme runs all tests, including UI tests.

Reminder: iOS is not tested.

Xcode sometimes hiccups on composed local SPM packages. If so, build each separately. *sigh*
